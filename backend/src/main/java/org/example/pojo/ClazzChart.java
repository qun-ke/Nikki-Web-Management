package org.example.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClazzChart {
    private List clazzList; //班级名称列表
    private List dataList; //每个班级的人数列表
}
