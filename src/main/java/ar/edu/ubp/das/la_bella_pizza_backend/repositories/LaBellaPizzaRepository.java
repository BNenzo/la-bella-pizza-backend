package ar.edu.ubp.das.la_bella_pizza_backend.repositories;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ActualizarContenidosNoPublicadosBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ActualizarReservaClienteRequestBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ClicksContenidosRestaurantesBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ContenidoNoPublicadoBean;
import ar.edu.ubp.das.la_bella_pizza_backend.components.SimpleJdbcCallFactory;

@Repository
public class LaBellaPizzaRepository {

  @Autowired
  private SimpleJdbcCallFactory jdbcCallFactory;

  // ===============================
  // REGISTRAR CLICK CONTENIDO
  // ===============================
  public void registrarClickContenido(ClicksContenidosRestaurantesBean body) {
    MapSqlParameterSource p = new MapSqlParameterSource()
        .addValue("nro_restaurante", body.getNroRestaurante())
        .addValue("nro_contenido", body.getNroContenido())
        .addValue("nro_click", body.getNroClick())
        .addValue("fecha_hora_registro", body.getFechaHoraRegistro())
        .addValue("nro_cliente", body.getNroCliente())
        .addValue("costo_click", body.getCostoClick());

    jdbcCallFactory.executeWithOutputs("sp_insert_click_contenido", "dbo", p);
  }

  // ===============================
  // OBTENER CONTENIDOS NO PUBLICADOS
  // ===============================
  public List<ContenidoNoPublicadoBean> getContenidosNoPublicados() {
    MapSqlParameterSource p = new MapSqlParameterSource();

    return jdbcCallFactory.executeQuery(
        "sp_get_contenidos_no_publicados",
        "dbo",
        p,
        "contenidos_no_publicados",
        ContenidoNoPublicadoBean.class);
  }

  // ===============================
  // INSERT CLIENTE DESDE RISTORINO
  // ===============================
  public void insertarClienteDesdeRistorino(
      Integer nroCliente,
      String apellido,
      String nombre,
      String correo,
      String telefonos) {

    MapSqlParameterSource p = new MapSqlParameterSource()
        .addValue("nro_cliente", nroCliente)
        .addValue("apellido", apellido)
        .addValue("nombre", nombre)
        .addValue("correo", correo)
        .addValue("telefonos", telefonos);

    jdbcCallFactory.execute(
        "sp_insert_cliente_desde_ristorino",
        "dbo",
        p);
  }

  // ===============================
  // INSERT RESERVA DESDE RISTORINO
  // ===============================
  public void crearReservaSucursal(
      String codReserva,
      Integer nroCliente,
      LocalDate fechaReserva,
      Integer nroRestaurante,
      Integer nroSucursal,
      String codZona,
      LocalTime horaReserva,
      Integer cantAdultos,
      Integer cantMenores,
      Double costoReserva) {

    MapSqlParameterSource p = new MapSqlParameterSource()
        .addValue("cod_reserva", codReserva)
        .addValue("nro_cliente", nroCliente)
        .addValue("fecha_reserva", fechaReserva)
        .addValue("nro_restaurante", nroRestaurante)
        .addValue("nro_sucursal", nroSucursal)
        .addValue("cod_zona", codZona)
        .addValue("hora_reserva", horaReserva)
        .addValue("cant_adultos", cantAdultos)
        .addValue("cant_menores", cantMenores)
        .addValue("costo_reserva", costoReserva);

    jdbcCallFactory.executeWithOutputs(
        "sp_crear_reserva_sucursal",
        "dbo",
        p);
  }

  // ACTUALIZAR LA RESERVA DE UN CLIENTE
  public void actualizarReservaCliente(ActualizarReservaClienteRequestBean request) {
    System.out.println(request.getCodReservaSucursal());
    MapSqlParameterSource params = new MapSqlParameterSource()
        .addValue("cod_reserva", request.getCodReservaSucursal())
        .addValue("cant_adultos", request.getCantAdultos())
        .addValue("cant_menores", request.getCantMenores())
        .addValue("fecha_reserva", request.getFechaReserva())
        .addValue("hora_reserva", request.getHoraReserva())
        .addValue("fecha_cancelacion", request.getFechaCancelacion())
        .addValue("cancelada", request.getFechaCancelacion() != null ? 1 : null);

    jdbcCallFactory.executeWithOutputs(
        "sp_actualizar_reserva_cliente",
        "dbo",
        params);
  }

  // ACTUALIZAR LOS CONTENIDOS NO PUBLICADOS A PUBLICADOS
  public void actualizarContenidoNoPublicadosAPublicados(ActualizarContenidosNoPublicadosBean request)
      throws JsonProcessingException {
    ObjectMapper om = new ObjectMapper();
    String json = om.writeValueAsString(request.getContenidos());

    MapSqlParameterSource params = new MapSqlParameterSource()
        .addValue("json", json);

    jdbcCallFactory.executeWithOutputs(
        "sp_actualizar_contenido_no_publicado",
        "dbo",
        params);
  }
}
