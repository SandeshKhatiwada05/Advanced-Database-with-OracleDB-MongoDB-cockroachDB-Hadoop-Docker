package org.javaFX;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NumberReducer implements Reducer {

    @Override
    public Map<String, Integer> reduce(Map<String, List<Integer>> mappedData) {

        Map<String, Integer> result = new HashMap<>();

        for (String key : mappedData.keySet()) {
            result.put(key, mappedData.get(key).size());
        }

        return result;
    }
}
