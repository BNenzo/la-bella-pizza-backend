package ar.edu.ubp.das.la_bella_pizza_backend.beans;

public class CrearReservaConClienteBean {

  private ClienteRestauranteBean cliente;
  private CrearReservaSucursalBean reserva;

  public CrearReservaConClienteBean() {
  }

  public ClienteRestauranteBean getCliente() {
    return cliente;
  }

  public void setCliente(ClienteRestauranteBean cliente) {
    this.cliente = cliente;
  }

  public CrearReservaSucursalBean getReserva() {
    return reserva;
  }

  public void setReserva(CrearReservaSucursalBean reserva) {
    this.reserva = reserva;
  }
}
