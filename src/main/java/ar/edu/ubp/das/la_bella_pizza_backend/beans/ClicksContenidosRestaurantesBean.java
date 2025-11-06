package ar.edu.ubp.das.la_bella_pizza_backend.beans;

import java.math.BigDecimal;

public class ClicksContenidosRestaurantesBean {

  private int nroRestaurante;
  private int nroContenido;
  private int nroClick;
  private String fechaHoraRegistro;
  private Integer nroCliente;
  private BigDecimal costoClick;

  public int getNroRestaurante() {
    return nroRestaurante;
  }

  public void setNroRestaurante(int nroRestaurante) {
    this.nroRestaurante = nroRestaurante;
  }

  public int getNroContenido() {
    return nroContenido;
  }

  public void setNroContenido(int nroContenido) {
    this.nroContenido = nroContenido;
  }

  public int getNroClick() {
    return nroClick;
  }

  public void setNroClick(int nroClick) {
    this.nroClick = nroClick;
  }

  public String getFechaHoraRegistro() {
    return fechaHoraRegistro;
  }

  public void setFechaHoraRegistro(String fechaHoraRegistro) {
    this.fechaHoraRegistro = fechaHoraRegistro;
  }

  public Integer getNroCliente() {
    return nroCliente;
  }

  public void setNroCliente(Integer nroCliente) {
    this.nroCliente = nroCliente;
  }

  public BigDecimal getCostoClick() {
    return costoClick;
  }

  public void setCostoClick(BigDecimal costoClick) {
    this.costoClick = costoClick;
  }

  @Override
  public String toString() {
    return "ClickContenidoRestaurante{" +
        "nroRestaurante=" + nroRestaurante +
        ", nroContenido=" + nroContenido +
        ", nroClick=" + nroClick +
        ", fechaHoraRegistro=" + fechaHoraRegistro +
        ", nroCliente=" + nroCliente +
        ", costoClick=" + costoClick +
        '}';
  }
}
