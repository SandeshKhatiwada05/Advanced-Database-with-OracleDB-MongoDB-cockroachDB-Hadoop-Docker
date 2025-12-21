package org.javaFX;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.*;

public class Driver {

    public static void main(String[] args) throws Exception {

        String filePath = "D:/Github/Advanced-Database-with-OracleDB-MongoDB-cockroachDB-Hadoop-Docker/MapReduce/1000Number.csv";

        Mapper mapper = new NumberMapper();
        Reducer reducer = new NumberReducer();

        Map<String, List<Integer>> mappedData = new HashMap<>();
        mappedData.put("EVEN", new ArrayList<>());
        mappedData.put("ODD", new ArrayList<>());
        mappedData.put("PRIME", new ArrayList<>());
        mappedData.put("NON_PRIME", new ArrayList<>());

        BufferedReader br = new BufferedReader(new FileReader(filePath));
        String line = br.readLine();
        br.close();

        String[] numbers = line.split(",");

        System.out.println("Data loaded from CSV.");
        System.out.println("Total numbers: " + numbers.length);

        // MAP PHASE
        for (String num : numbers) {
            int value = Integer.parseInt(num.trim());
            mapper.map(value, mappedData);
        }

        // REDUCE PHASE
        Map<String, Integer> finalResult = reducer.reduce(mappedData);

        System.out.println("\n---- MAP PHASE ----");
        System.out.println("Mapper calls : " + NumberMapper.getMapperCallCount());
        System.out.println("Total mapped key-value pairs : " + NumberMapper.getTotalKeyValuePairs());

        NumberMapper.getEmittedKeyCount()
                .forEach((k, v) -> System.out.println(k + " emitted : " + v));

        System.out.println("\n---- REDUCER PHASE ----");
        System.out.println("FINAL REDUCED OUTPUT");

        finalResult.forEach(
                (k, v) -> System.out.println(k + " COUNT = " + v)
        );
    }
}
