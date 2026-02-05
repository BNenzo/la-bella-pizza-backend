package ar.edu.ubp.das.la_bella_pizza_backend.beans;

public class ActualizarReservaClienteRequestBean {

  private String fechaReserva;
  private Integer cantAdultos;
  private String horaReserva;
  private String codReservaSucursal;
  private String fechaCancelacion;

  public String getFechaCancelacion() {
    return fechaCancelacion;
  }

  public void setFechaCancelacion(String fechaCancelacion) {
    this.fechaCancelacion = fechaCancelacion;
  }

  public String getCodReservaSucursal() {
    return codReservaSucursal;
  }

  public void setCodReservaSucursal(String codReservaSucursal) {
    this.codReservaSucursal = codReservaSucursal;
  }

  public String getFechaReserva() {
    return fechaReserva;
  }

  public void setFechaReserva(String fechaReserva) {
    this.fechaReserva = fechaReserva;
  }

  public String getHoraReserva() {
    return horaReserva;
  }

  public void setHoraReserva(String horaReserva) {
    this.horaReserva = horaReserva;
  }

  public Integer getCantAdultos() {
    return cantAdultos;
  }

  public void setCantAdultos(Integer cantAdultos) {
    this.cantAdultos = cantAdultos;
  }
}
