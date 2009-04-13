package 
{
	// @author Kilian Valkhof - kilian@kilianvalkhof.com
	// Copyright 2009 Kilian Valkhof
	// Licenced under MIT - http://www.opensource.org/licenses/mit-license.php
	
	// @todo - could be added in the future
	// - vertical labels
	// - grid
	
	import flash.display.Sprite;
	import flash.events.*;
	import mx.controls.Text;
	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.geom.renderables.Line3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.special.LineMaterial;
	import org.papervision3d.materials.shadematerials.GouraudMaterial;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.lights.PointLight3D;
	
	[swf(framerate = "31", backgroundColor = "0")]
	public class Main extends BasicView 
	{
		public var light : PointLight3D;
		public var axis : lines;
		public var barchart:graph;
		
		public function Main() {	
			
			//add simple light to scene
			light = new PointLight3D();
			light.x = -400;
			light.y = 400;
					
			/* edit this! */
			var graphWidth:uint = 1000;
			var graphHeight:uint = 500;
			var data:Array = new Array(20, 12, 16, 18, 24, 10, 4, 50, 33);
			var datalabels:Array = new Array("firefox", "g-edit", "wine", "pidgin", "x-chat", "terminal","banshee","x-server","git");
			var color : GouraudMaterial = new GouraudMaterial(light, 0x008800, 0x000000);
			/* until here! */
			
			barchart = new graph(data, datalabels, color, graphWidth, graphHeight);
			axis = new lines(graphWidth,graphHeight); 
			scene.addChild(axis);
			
			scene.addChild(barchart);
			_camera.lookAt(barchart);
			startRendering();
		}
		override protected function onRenderTick(event:Event = null):void {
			super.onRenderTick(event);
			
			// just for fun. positioning can be improved later, or placed within other scenes and then you won't even need this
			barchart.rotationY = (mouseX / stage.width*0.5) * 360;
			axis.rotationY = (mouseX / stage.width * 0.5) * 360;

		}
		
		
	}
	
}