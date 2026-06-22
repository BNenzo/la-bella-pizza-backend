package ar.edu.ubp.das.la_bella_pizza_backend.beans;

public class ObtenerDisponibilidadHorariaZonaRequestBean {
  private Integer nroSucursal;

  public Integer getNroSucursal() {
    return nroSucursal;
  }

  public void setNroSucursal(Integer nroSucursal) {
    this.nroSucursal = nroSucursal;
  }

  private String codZona;

  public String getCodZona() {
    return codZona;
  }

  public void setCodZona(String codZona) {
    this.codZona = codZona;
  }

  private String fechaReserva;

  public String getFechaReserva() {
    return fechaReserva;
  }

  public void setFechaReserva(String fechaReserva) {
    this.fechaReserva = fechaReserva;
  }
}
