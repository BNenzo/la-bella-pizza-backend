package ar.edu.ubp.das.la_bella_pizza_backend.beans;

public class CrearReservaConClienteRequestDTO {

  private CrearReservaClienteDTO cliente;
  private CrearReservaRestaranteDTO reserva;

  public CrearReservaConClienteRequestDTO() {
  }

  public CrearReservaClienteDTO getCliente() {
    return cliente;
  }

  public void setCliente(CrearReservaClienteDTO cliente) {
    this.cliente = cliente;
  }

  public CrearReservaRestaranteDTO getReserva() {
    return reserva;
  }

  public void setReserva(CrearReservaRestaranteDTO reserva) {
    this.reserva = reserva;
  }
}
