package ar.edu.ubp.das.la_bella_pizza_backend.repositories;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Repository;

import ar.edu.ubp.das.la_bella_pizza_backend.beans.ClicksContenidosRestaurantesBean;
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

}
