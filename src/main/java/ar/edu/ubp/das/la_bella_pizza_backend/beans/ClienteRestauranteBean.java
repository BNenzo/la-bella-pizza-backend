package ar.edu.ubp.das.la_bella_pizza_backend.beans;

public class ClienteRestauranteBean {

  private Integer nroCliente;
  private String apellido;
  private String nombre;
  private String correo;
  private String telefonos;

  public ClienteRestauranteBean() {
  }

  public Integer getNroCliente() {
    return nroCliente;
  }

  public void setNroCliente(Integer nroCliente) {
    this.nroCliente = nroCliente;
  }

  public String getApellido() {
    return apellido;
  }

  public void setApellido(String apellido) {
    this.apellido = apellido;
  }

  public String getNombre() {
    return nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  public String getCorreo() {
    return correo;
  }

  public void setCorreo(String correo) {
    this.correo = correo;
  }

  public String getTelefonos() {
    return telefonos;
  }

  public void setTelefonos(String telefonos) {
    this.telefonos = telefonos;
  }
}
