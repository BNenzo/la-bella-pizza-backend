package ar.edu.ubp.das.la_bella_pizza_backend.beans;

public class ObtenerDisponibilidadHorariaZonaResponseBean {
  private Integer nroRestaurante;
  private Integer nroSucursal;
  private String codZona;
  private Integer cantComensales;
  private Integer permiteMenores;
  private String horaDesde;
  private String horaHasta;
  private Integer habilitado;
  private Integer cantidadReservada;
  private Integer cupoDisponible;

  public Integer getNroRestaurante() {
    return nroRestaurante;
  }

  public void setNroRestaurante(Integer nroRestaurante) {
    this.nroRestaurante = nroRestaurante;
  }

  public Integer getNroSucursal() {
    return nroSucursal;
  }

  public void setNroSucursal(Integer nroSucursal) {
    this.nroSucursal = nroSucursal;
  }

  // Datos de la zona

  public String getCodZona() {
    return codZona;
  }

  public void setCodZona(String codZona) {
    this.codZona = codZona;
  }

  public Integer getCantComensales() {
    return cantComensales;
  }

  public void setCantComensales(Integer cantComensales) {
    this.cantComensales = cantComensales;
  }

  public Integer getPermiteMenores() {
    return permiteMenores;
  }

  public void setPermiteMenores(Integer permiteMenores) {
    this.permiteMenores = permiteMenores;
  }

  // Datos del turno

  public String getHoraDesde() {
    return horaDesde;
  }

  public void setHoraDesde(String horaDesde) {
    this.horaDesde = horaDesde;
  }

  public String getHoraHasta() {
    return horaHasta;
  }

  public void setHoraHasta(String horaHasta) {
    this.horaHasta = horaHasta;
  }

  public Integer getHabilitado() {
    return habilitado;
  }

  public void setHabilitado(Integer habilitado) {
    this.habilitado = habilitado;
  }

  // Disponibilidad calculada

  public Integer getCantidadReservada() {
    return cantidadReservada;
  }

  public void setCantidadReservada(Integer cantidadReservada) {
    this.cantidadReservada = cantidadReservada;
  }

  public Integer getCupoDisponible() {
    return cupoDisponible;
  }

  public void setCupoDisponible(Integer cupoDisponible) {
    this.cupoDisponible = cupoDisponible;
  }

}
