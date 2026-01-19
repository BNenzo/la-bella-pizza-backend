package ar.edu.ubp.das.la_bella_pizza_backend.beans;

import java.math.BigDecimal;

public class ContenidoNoPublicadoBean {

  private int nroRestaurante;
  private int nroContenido;
  private String contenidoAPublicar;
  private String imagenAPublicar;
  private int publicado;
  private BigDecimal costoClick;
  private Integer nroSucursal;

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

  public String getContenidoAPublicar() {
    return contenidoAPublicar;
  }

  public void setContenidoAPublicar(String contenidoAPublicar) {
    this.contenidoAPublicar = contenidoAPublicar;
  }

  public String getImagenAPublicar() {
    return imagenAPublicar;
  }

  public void setImagenAPublicar(String imagenAPublicar) {
    this.imagenAPublicar = imagenAPublicar;
  }

  public int getPublicado() {
    return publicado;
  }

  public void setPublicado(int publicado) {
    this.publicado = publicado;
  }

  public BigDecimal getCostoClick() {
    return costoClick;
  }

  public void setCostoClick(BigDecimal costoClick) {
    this.costoClick = costoClick;
  }

  public Integer getNroSucursal() {
    return nroSucursal;
  }

  public void setNroSucursal(Integer nroSucursal) {
    this.nroSucursal = nroSucursal;
  }
}
