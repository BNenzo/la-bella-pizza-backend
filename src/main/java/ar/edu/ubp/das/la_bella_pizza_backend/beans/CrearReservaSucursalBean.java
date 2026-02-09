package ar.edu.ubp.das.la_bella_pizza_backend.beans;

import java.time.LocalDate;
import java.time.LocalTime;

public class CrearReservaSucursalBean {

  private String codReserva;
  private Integer nroCliente;
  private LocalDate fechaReserva;
  private Integer nroRestaurante;
  private Integer nroSucursal;
  private String codZona;
  private LocalTime horaReserva;
  private Integer cantAdultos;
  private Integer cantMenores;
  private Double costoReserva;

  public CrearReservaSucursalBean() {
  }

  public String getCodReserva() {
    return codReserva;
  }

  public void setCodReserva(String codReserva) {
    this.codReserva = codReserva;
  }

  public Integer getNroCliente() {
    return nroCliente;
  }

  public void setNroCliente(Integer nroCliente) {
    this.nroCliente = nroCliente;
  }

  public LocalDate getFechaReserva() {
    return fechaReserva;
  }

  public void setFechaReserva(LocalDate fechaReserva) {
    this.fechaReserva = fechaReserva;
  }

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

  public String getCodZona() {
    return codZona;
  }

  public void setCodZona(String codZona) {
    this.codZona = codZona;
  }

  public LocalTime getHoraReserva() {
    return horaReserva;
  }

  public void setHoraReserva(LocalTime horaReserva) {
    this.horaReserva = horaReserva;
  }

  public Integer getCantAdultos() {
    return cantAdultos;
  }

  public void setCantAdultos(Integer cantAdultos) {
    this.cantAdultos = cantAdultos;
  }

  public Integer getCantMenores() {
    return cantMenores;
  }

  public void setCantMenores(Integer cantMenores) {
    this.cantMenores = cantMenores;
  }

  public Double getCostoReserva() {
    return costoReserva;
  }

  public void setCostoReserva(Double costoReserva) {
    this.costoReserva = costoReserva;
  }
}
