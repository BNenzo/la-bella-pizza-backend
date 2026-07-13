package ar.edu.ubp.das.la_bella_pizza_backend.resources;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;

import ar.edu.ubp.das.la_bella_pizza_backend.beans.ActualizarContenidosNoPublicadosRequestBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.RegistarClicksContenidosRestaurantesRequestBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ContenidoNoPublicadoResponseBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.CrearReservaConClienteRequestDTO;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ObtenerDisponibilidadHorariaZonaResponseBean;
import ar.edu.ubp.das.la_bella_pizza_backend.repositories.LaBellaPizzaRepository;
import ar.edu.ubp.das.la_bella_pizza_backend.utils.Utils;

@RestController
@RequestMapping("/la-bella-pizza")
public class LaBellaPizzaResource {

  @Autowired
  private LaBellaPizzaRepository laBellaPizzaRepository;

  @PostMapping("/registrar_click_contenido")
  public ResponseEntity<String> registrarClickContenido(
      @RequestBody RegistarClicksContenidosRestaurantesRequestBean body) {
    if (body.getNroCliente() != null) { // Cambiar
      Integer nroCliente = laBellaPizzaRepository.insertarClienteDesdeRistorino(
          body.getApellido(),
          body.getNombre(),
          body.getCorreo(),
          body.getTelefonos());

      body.setNroCliente(nroCliente);
    }

    laBellaPizzaRepository.registrarClickContenido(body);
    return ResponseEntity.ok().build();
  }

  @GetMapping("/contenidos/no-publicados")
  public ResponseEntity<List<ContenidoNoPublicadoResponseBean>> getContenidosNoPublicados() {
    return ResponseEntity.ok(
        laBellaPizzaRepository.getContenidosNoPublicados());
  }

  // ===============================
  // INSERT RESERVA DESDE RISTORINO
  // ===============================
  @PostMapping("/reservas")
  @Transactional
  public ResponseEntity<Map<String, Object>> crearReservaSucursal(
      @RequestBody CrearReservaConClienteRequestDTO body) {

    List<ObtenerDisponibilidadHorariaZonaResponseBean> horariosPorZona = laBellaPizzaRepository
        .obtenerDisponibilidadHorariaZona(body.getReserva().getNroSucursal(),
            body.getReserva().getCodZona(),
            body.getReserva().getFechaReserva());

    String horaRequest = body.getReserva().getHoraReserva().toString();

    Optional<ObtenerDisponibilidadHorariaZonaResponseBean> opt = horariosPorZona.stream()
        .filter(h -> horaRequest.equals(h.getHoraDesde().substring(0, 5)))
        .findFirst();

    if (opt.isEmpty()) {
      // no existe turno para esa hora
      throw new RuntimeException("RESERVA_TURNO_INEXISTENTE");
    }

    ObtenerDisponibilidadHorariaZonaResponseBean turno = opt.get();

    // Validaciones sobre el encontrado
    if (turno.getHabilitado() != null && turno.getHabilitado() == 0) {
      throw new RuntimeException("RESERVA_TURNO_NO_HABILITADO");
    }
    if (turno.getCupoDisponible() == null || turno.getCupoDisponible() <= 0) {
      throw new RuntimeException("RESERVA_SIN_CUPO");
    }
    if (turno.getCupoDisponible() < body.getReserva().getCantAdultos() + body.getReserva().getCantMenores()) {
      throw new RuntimeException("RESERVA_CUPO_INSUFICIENTE");
    }

    String codReservaSucursal = Utils.generarCodigoReserva();

    // Insertar cliente (si no existe)
    Integer nroCliente = laBellaPizzaRepository.insertarClienteDesdeRistorino(
        body.getCliente().getApellido(),
        body.getCliente().getNombre(),
        body.getCliente().getCorreo(),
        body.getCliente().getTelefonos());

    // Insertar reserva
    laBellaPizzaRepository.crearReservaSucursal(
        codReservaSucursal,
        nroCliente,
        body.getReserva().getFechaReserva(),
        body.getReserva().getNroSucursal(),
        body.getReserva().getCodZona(),
        body.getReserva().getHoraReserva(),
        body.getReserva().getCantAdultos(),
        body.getReserva().getCantMenores(),
        body.getReserva().getCostoReserva());

    return ResponseEntity.ok(Map.of(
        "codReservaSucursal", codReservaSucursal));
  }

  // ACTUALIZAR LOS CONTENIDOS NO PUBLICADOS A PUBLICADOS
  @PostMapping("/contenidos/actualizar-publicados")
  public ResponseEntity<String> actualizarContenidoPublicado(
      @RequestBody ActualizarContenidosNoPublicadosRequestBean body) throws JsonProcessingException {
    laBellaPizzaRepository.actualizarContenidoNoPublicadosAPublicados(body);
    return ResponseEntity.status(HttpStatus.CREATED).build();
  }

  // OBTENER DISPONIBILIDAD HORARIA POR ZONA
  @GetMapping("/reservas/obtener-disponibilidad-horaria-zona")
  public ResponseEntity<List<ObtenerDisponibilidadHorariaZonaResponseBean>> obtenerDisponibilidadHorariaZona(
      @RequestParam Integer nroSucursal,
      @RequestParam String codZona,
      @RequestParam LocalDate fechaAReservar) throws JsonProcessingException {
    return ResponseEntity
        .ok(laBellaPizzaRepository.obtenerDisponibilidadHorariaZona(nroSucursal, codZona,
            fechaAReservar));
  }

}
