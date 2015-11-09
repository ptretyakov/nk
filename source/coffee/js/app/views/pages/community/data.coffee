define ( require ) ->
	'use strict'

	Graph =
		nodes: [
			{id: 0, x:-50, y:275, r: 0, fixed: true }
			{id: 1, x:-50, y:125, r: 0, fixed: true }
			{id: 2, x:60, y:-25, r: 0, fixed: true }
			{id: 3, x:0, y:550, r: 0, fixed: true }
			{id: 4, x:80, y:30, r: 10 }
			{id: 5, x:15, y:240, r: 10 }
			{id: 6, x:250, y:490, r: 10 }
			{id: 7, x:280, y:265, r: 10 }
			{id: 8, x:295, y:8, r: 10 }
			{id: 9, x:265, y:195, r: 10 }
			{id: 10, x:5, y:20, r: 6 }
			{id: 11, x:280, y:40, r: 6 }
			{id: 12, x:165, y:250, r: 6 }
			{id: 13, x:40, y:225, r: 6 }
			{id: 14, x:12, y:480, r: 6 }
			{id: 15, x:275, y:465, r: 6 }
			{id: 16, x:320, y:-15, r: 0, fixed: true }
			{id: 17, x:340, y:270, r: 0, fixed: true }
			{id: 18, x:295, y:525, r: 0, fixed: true }
		]
		links: [
			{source: 0, target: 1}
			{source: 0, target: 3}
			{source: 0, target: 14, z: 1}
			{source: 0, target: 5}
			{source: 1, target: 2}
			{source: 1, target: 4}
			{source: 1, target: 5}
			{source: 1, target: 10, z: 1}
			{source: 1, target: 13}
			{source: 2, target: 4}
			{source: 2, target: 8}
			{source: 2, target: 10, z: 1}
			{source: 3, target: 14, z: 1}
			{source: 3, target: 6}
			{source: 4, target: 10, z: 1}
			{source: 4, target: 8}
			{source: 4, target: 11, z: 1}
			{source: 4, target: 13, z: 1}
			{source: 4, target: 5}
			{source: 5, target: 13, z: 1}
			{source: 5, target: 9}
			{source: 5, target: 6}
			{source: 5, target: 14, z: 1}
			{source: 6, target: 7}
			{source: 6, target: 15, z: 1}
			{source: 6, target: 14, z: 1}
			{source: 7, target: 15, z: 1}
			{source: 7, target: 12, z: 1}
			{source: 7, target: 9}
			{source: 7, target: 8}
			{source: 8, target: 11, z: 1}
			{source: 8, target: 9}
			{source: 9, target: 13, z: 1}
			{source: 9, target: 12, z: 1}
			{source: 10, target: 13, z: 1}
			{source: 11, target: 12, z: 1}
			{source: 12, target: 13, z: 1}
			{source: 12, target: 14, z: 1}
			{source: 15, target: 14, z: 1}
			{source: 16, target: 8}
			{source: 17, target: 7}
			{source: 18, target: 6}
		]
