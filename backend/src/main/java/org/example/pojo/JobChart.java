package org.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class JobChart {
    private List jobList;
    private  List dataList;
}
//public class JobOption {
//    private List jobList;
//    private List dataList;
//}