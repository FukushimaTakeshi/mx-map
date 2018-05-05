<template>
</template>

<script>
import * as d3 from 'd3';

export default {
  mounted: function() {
    let g,
    width = 900,
    height = 650;

    // svg要素を作成し、データの受け皿となるg要素を追加している
    map = d3.select('#map').append('svg')
        .attr('width', width)
        .attr('height', height)
        .append('g');

    // 同じディレクトリにあるgeojsonファイルをhttp経由で読み込む
    d3.json("https://raw.githubusercontent.com/gist/FukushimaTakeshi/70aba34689ae8d9117793b70faf728b1/raw/856d759a64701a5fd6f70bb751019fd1de60e46e/pref.json", function(json) {

      // 投影を処理する関数を用意する。データからSVGのPATHに変換するため。
      let projection = d3.geoMercator()
                     .scale(1000)
                     .center(d3.geoCentroid(json))  // データから中心点を計算
                     .translate([width / 2, height / 2]);

      // pathジェネレータ関数
      let path = d3.geoPath().projection(projection);
      //  これがenterしたデータ毎に呼び出されpath要素のd属性に
      //  geoJSONデータから変換した値を入れる

      map.selectAll('path')
         .data(json.features)
         .enter()
         .append('path')
         .attr("class", function(d) {
          //     // return "region_cod region_cod" + d.properties.region_cod;
           return "region";
         })
         .attr('d', path)
         // .attr("fill", function(d,i){
         //   return d.properties.region_cod === "Hiroshima" ? "darkgreen" : "green";
         // }) // 広島だけダークグリーン
         .on('mouseover', function(d){
              // mouseoverの時のインタラクション
         })
         .on('click', function(d) {
              // clickされた時のインタラクション
         })
         .style("stroke", "#ffffff")
         .style("stroke-width", 0.2)
         .style("fill", function(d){return rand_color(d.properties.region);});
    });
  }
}

function rand_color(region){
  switch (region){
    case 'Chugoku':
      return "red";
      break;
    case 'Kyushu':
      return 'blue';
      break;
    case 'Okinawa':
      return 'blue';
      break;
    case 'Shikoku':
      return 'purple';
      break;
    case 'Kanto':
      return 'pink';
      break;
    case 'Chubu':
      return 'indigo';
      break;
    case 'Kinki':
      return 'green';
      break;
    case 'Tohoku':
      return 'orange';
      break;
    case 'Hokkaido':
      return 'teal';
      break;
  }
}
</script>
