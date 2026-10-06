package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.pojo.EmpExpr;

import java.util.List;

@Mapper
public interface EmpExprMapper {
    //批量增加员工信息
    void addBatch(List<EmpExpr> exprList);
    //批量删除员工工作经历信息
    void deleteByExprIds(List<Integer> empIds);
}
