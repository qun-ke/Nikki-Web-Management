<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as echarts from 'echarts'
import { studentDegreeApi, studentCountApi } from '@/api/report'
import { ElMessage } from 'element-plus'

const degreeChart = ref(null)
const countChart = ref(null)
let degreeInstance = null
let countInstance = null

//学员学历统计 - 环形饼图
const initDegreeChart = (data) => {
  degreeInstance = echarts.init(degreeChart.value)
  degreeInstance.setOption({
    title: { text: '学员学历统计', left: 'center' },
    tooltip: { trigger: 'item', formatter: '{b}: {c}人 ({d}%)' },
    legend: { bottom: 0 },
    color: ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#9B59B6'],
    series: [
      {
        name: '学历',
        type: 'pie',
        radius: ['40%', '68%'], //环形
        center: ['50%', '48%'],
        avoidLabelOverlap: true,
        itemStyle: { borderRadius: 6, borderColor: '#fff', borderWidth: 2 },
        label: { formatter: '{b}: {c}人' },
        data: data
      }
    ]
  })
}

//班级人数统计 - 柱状图
const initCountChart = (data) => {
  countInstance = echarts.init(countChart.value)
  countInstance.setOption({
    title: { text: '班级人数统计', left: 'center' },
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '20%', containLabel: true },
    xAxis: {
      type: 'category',
      data: data.clazzList,
      axisLabel: { interval: 0, rotate: 30 }
    },
    yAxis: { type: 'value', minInterval: 1 },
    series: [
      {
        type: 'bar',
        data: data.dataList,
        barWidth: '45%',
        itemStyle: {
          borderRadius: [4, 4, 0, 0],
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: '#83bff6' },
            { offset: 1, color: '#188df0' }
          ])
        },
        label: { show: true, position: 'top' }
      }
    ]
  })
}

//窗口大小变化时重绘图表
const resizeCharts = () => {
  degreeInstance && degreeInstance.resize()
  countInstance && countInstance.resize()
}

onMounted(async () => {
  const degreeRes = await studentDegreeApi()
  if (degreeRes.code) {
    initDegreeChart(degreeRes.data)
  } else {
    ElMessage.error(degreeRes.msg)
  }

  const countRes = await studentCountApi()
  if (countRes.code) {
    initCountChart(countRes.data)
  } else {
    ElMessage.error(countRes.msg)
  }

  window.addEventListener('resize', resizeCharts)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', resizeCharts)
  degreeInstance && degreeInstance.dispose()
  countInstance && countInstance.dispose()
})
</script>

<template>
  <div>
    <h1>学员信息统计</h1>
    <el-row :gutter="20" class="chart-row">
      <el-col :span="12">
        <el-card shadow="hover">
          <div ref="degreeChart" class="chart-box"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="hover">
          <div ref="countChart" class="chart-box"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.chart-row {
  margin-top: 10px;
}

.chart-box {
  width: 100%;
  height: 420px;
}
</style>
