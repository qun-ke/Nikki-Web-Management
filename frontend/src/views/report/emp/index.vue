<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import * as echarts from 'echarts'
import { empGenderApi, empJobApi } from '@/api/report'
import { ElMessage } from 'element-plus'

const genderChart = ref(null)
const jobChart = ref(null)
let genderInstance = null
let jobInstance = null

//员工性别统计 - 饼图
const initGenderChart = (data) => {
  genderInstance = echarts.init(genderChart.value)
  genderInstance.setOption({
    title: { text: '员工性别统计', left: 'center' },
    tooltip: { trigger: 'item', formatter: '{b}: {c}人 ({d}%)' },
    legend: { bottom: 0 },
    color: ['#409EFF', '#F56C6C'],
    series: [
      {
        name: '性别',
        type: 'pie',
        radius: '60%',
        center: ['50%', '48%'],
        data: data,
        label: { formatter: '{b}: {c}人' }
      }
    ]
  })
}

//员工职位人数统计 - 柱状图
const initJobChart = (data) => {
  jobInstance = echarts.init(jobChart.value)
  jobInstance.setOption({
    title: { text: '员工职位统计', left: 'center' },
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '15%', containLabel: true },
    xAxis: {
      type: 'category',
      data: data.jobList,
      axisLabel: { interval: 0, rotate: 25 }
    },
    yAxis: { type: 'value', minInterval: 1 },
    series: [
      {
        type: 'bar',
        data: data.dataList,
        barWidth: '45%',
        itemStyle: { color: '#409EFF', borderRadius: [4, 4, 0, 0] },
        label: { show: true, position: 'top' }
      }
    ]
  })
}

//窗口大小变化时重绘图表
const resizeCharts = () => {
  genderInstance && genderInstance.resize()
  jobInstance && jobInstance.resize()
}

onMounted(async () => {
  const genderRes = await empGenderApi()
  if (genderRes.code) {
    initGenderChart(genderRes.data)
  } else {
    ElMessage.error(genderRes.msg)
  }

  const jobRes = await empJobApi()
  if (jobRes.code) {
    initJobChart(jobRes.data)
  } else {
    ElMessage.error(jobRes.msg)
  }

  window.addEventListener('resize', resizeCharts)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', resizeCharts)
  genderInstance && genderInstance.dispose()
  jobInstance && jobInstance.dispose()
})
</script>

<template>
  <div>
    <h1>员工信息统计</h1>
    <el-row :gutter="20" class="chart-row">
      <el-col :span="12">
        <el-card shadow="hover">
          <div ref="genderChart" class="chart-box"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="hover">
          <div ref="jobChart" class="chart-box"></div>
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
