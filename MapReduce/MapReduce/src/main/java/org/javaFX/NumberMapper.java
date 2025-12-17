package org.javaFX;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NumberMapper implements Mapper {

    private static int mapperCallCount = 0;
    private static int totalKeyValuePairs = 0;

    private static final Map<String, Integer> emittedKeyCount = new HashMap<>();

    static {
        emittedKeyCount.put("EVEN", 0);
        emittedKeyCount.put("ODD", 0);
        emittedKeyCount.put("PRIME", 0);
        emittedKeyCount.put("NON_PRIME", 0);
    }

    @Override
    public void map(int number, Map<String, List<Integer>> output) {
        mapperCallCount++;

        if (number % 2 == 0) {
            output.get("EVEN").add(number);
            emittedKeyCount.put("EVEN", emittedKeyCount.get("EVEN") + 1);
            totalKeyValuePairs++;
        } else {
            output.get("ODD").add(number);
            emittedKeyCount.put("ODD", emittedKeyCount.get("ODD") + 1);
            totalKeyValuePairs++;
        }

        if (isPrime(number)) {
            output.get("PRIME").add(number);
            emittedKeyCount.put("PRIME", emittedKeyCount.get("PRIME") + 1);
            totalKeyValuePairs++;
        } else {
            output.get("NON_PRIME").add(number);
            emittedKeyCount.put("NON_PRIME", emittedKeyCount.get("NON_PRIME") + 1);
            totalKeyValuePairs++;
        }
    }

    public static int getMapperCallCount() {
        return mapperCallCount;
    }

    public static int getTotalKeyValuePairs() {
        return totalKeyValuePairs;
    }

    public static Map<String, Integer> getEmittedKeyCount() {
        return emittedKeyCount;
    }

    private boolean isPrime(int n) {
        if (n <= 1) return false;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}
