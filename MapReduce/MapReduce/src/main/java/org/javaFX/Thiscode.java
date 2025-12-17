package org.javaFX;
import java.util.Random;

public class Thiscode {


        public static void main(String[] args) {
            Random random = new Random();

            for (int i = 1; i < 1001; i++) {

                System.out.print(i);

                if (i < 999) {
                    System.out.print(",");
                }
            }

    }

}
