package ar.edu.ubp.das.la_bella_pizza_backend.resources;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ar.edu.ubp.das.la_bella_pizza_backend.beans.ActualizarReservaClienteRequestBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ClicksContenidosRestaurantesBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ContenidoNoPublicadoBean;
import ar.edu.ubp.das.la_bella_pizza_backend.repositories.LaBellaPizzaRepository;

@RestController
@RequestMapping("/la-bella-pizza")
public class LaBellaPizzaResource {

  @Autowired
  private LaBellaPizzaRepository laBellaPizzaRepository;

  @PostMapping("/registrar_click_contenido")
  public ResponseEntity<String> registrarClickContenido(@RequestBody ClicksContenidosRestaurantesBean body) {
    laBellaPizzaRepository.registrarClickContenido(body);
    return ResponseEntity.ok("ok");
  }

  @GetMapping("/contenidos/no-publicados")
  public ResponseEntity<List<ContenidoNoPublicadoBean>> getContenidosNoPublicados() {
    return ResponseEntity.ok(
        laBellaPizzaRepository.getContenidosNoPublicados());
  }

  // ACTUALIZAR LA RESERVA DE UN CLIENTE
  @PutMapping("/reservas/cliente")
  public ResponseEntity<String> actualizarReservaCliente(
      @RequestBody ActualizarReservaClienteRequestBean body) {

    laBellaPizzaRepository.actualizarReservaCliente(body);
    return ResponseEntity.ok("ok");
  }
}
