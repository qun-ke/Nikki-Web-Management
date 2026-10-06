package org.example.pojo;

import lombok.Data;

@Data
public class StudentQueryParam {
    private Integer page = 1; //分页页码，默认1
    private Integer pageSize = 10; //每页记录数，默认10
    private String name; //学员姓名
    private Integer degree; //学历
    private Integer clazzId; //班级ID
}
