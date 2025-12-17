package org.javaFX;
import java.util.List;
import java.util.Map;

public interface Reducer {
    Map<String, Integer> reduce(Map<String, List<Integer>> mappedData);
}
