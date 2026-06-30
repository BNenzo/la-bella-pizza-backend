package ar.edu.ubp.das.la_bella_pizza_backend.beans;

import java.math.BigDecimal;

public class RegistarClicksContenidosRestaurantesRequestBean {

  private String codContenidoRestaurante;
  private int nroContenido;
  private int nroClick;
  private String fechaHoraRegistro;
  private Integer nroCliente;
  private BigDecimal costoClick;

  private String apellido;

  public String getCodContenidoRestaurante() {
    return codContenidoRestaurante;
  }

  public void setCodContenidoRestaurante(String codContenidoRestaurante) {
    this.codContenidoRestaurante = codContenidoRestaurante;
  }

  public String getApellido() {
    return apellido;
  }

  public void setApellido(String apellido) {
    this.apellido = apellido;
  }

  private String nombre;

  public String getNombre() {
    return nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  private String correo;

  public String getCorreo() {
    return correo;
  }

  public void setCorreo(String correo) {
    this.correo = correo;
  }

  private String telefonos;

  public String getTelefonos() {
    return telefonos;
  }

  public void setTelefonos(String telefonos) {
    this.telefonos = telefonos;
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
        "codContenidoRestaurante=" + codContenidoRestaurante +
        ", nroContenido=" + nroContenido +
        ", nroClick=" + nroClick +
        ", fechaHoraRegistro=" + fechaHoraRegistro +
        ", nroCliente=" + nroCliente +
        ", costoClick=" + costoClick +
        '}';
  }
}
