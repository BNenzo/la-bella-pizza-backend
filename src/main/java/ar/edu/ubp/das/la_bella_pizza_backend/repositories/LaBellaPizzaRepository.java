package ar.edu.ubp.das.la_bella_pizza_backend.repositories;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Repository;

import ar.edu.ubp.das.la_bella_pizza_backend.beans.ActualizarReservaClienteRequestBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ClicksContenidosRestaurantesBean;
import ar.edu.ubp.das.la_bella_pizza_backend.beans.ContenidoNoPublicadoBean;
import ar.edu.ubp.das.la_bella_pizza_backend.components.SimpleJdbcCallFactory;

@Repository
public class LaBellaPizzaRepository {

  @Autowired
  private SimpleJdbcCallFactory jdbcCallFactory;

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

  // OBTENER CONTENIDOS NO PUBLICADOS
  public List<ContenidoNoPublicadoBean> getContenidosNoPublicados() {
    MapSqlParameterSource p = new MapSqlParameterSource();

    return jdbcCallFactory.executeQuery(
        "sp_get_contenidos_no_publicados",
        "dbo",
        p,
        "contenidos_no_publicados",
        ContenidoNoPublicadoBean.class);
  }

  // ACTUALIZAR LA RESERVA DE UN CLIENTE
  public void actualizarReservaCliente(ActualizarReservaClienteRequestBean request) {
    System.out.println(request.getCodReservaSucursal());
    MapSqlParameterSource params = new MapSqlParameterSource()
        .addValue("cod_reserva", request.getCodReservaSucursal())
        .addValue("cant_adultos", request.getCantAdultos())
        .addValue("fecha_reserva", request.getFechaReserva())
        .addValue("hora_reserva", request.getHoraReserva())
        .addValue("fecha_cancelacion", request.getFechaCancelacion())
        .addValue("cancelada", request.getFechaCancelacion() != null ? 1 : null);

    jdbcCallFactory.executeWithOutputs(
        "sp_actualizar_reserva_cliente",
        "dbo",
        params);
  }

}
