package ar.edu.ubp.das.la_bella_pizza_backend.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class Utils {
  private static final String LETRAS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyMMddHHmmss");
  private static final Random RANDOM = new Random();

  public static String generarCodigoReserva() {

    StringBuilder prefijo = new StringBuilder();
    for (int i = 0; i < 4; i++) {
      prefijo.append(LETRAS.charAt(RANDOM.nextInt(LETRAS.length())));
    }

    String fechaHora = LocalDateTime.now().format(FORMATTER);

    return prefijo + fechaHora;
  }
}
