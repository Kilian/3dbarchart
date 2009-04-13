package  
{
	import org.papervision3d.core.proto.DisplayObjectContainer3D;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.shadematerials.GouraudMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.papervision3d.objects.primitives.Plane
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import org.papervision3d.materials.MovieMaterial;

	public class graph extends DisplayObject3D
	{
		public var graphWidth:uint;
		public var graphHeight:uint;
		public var barPadding:uint;
		public var barWidth:uint;
		public var barColor:GouraudMaterial;
		public var sortedArray:Array;
		public var barHeightMultiplicator:uint;
		public var barHeight:uint;
		public var barOffset:uint;
		public var barContainer:DisplayObject3D;
		
		public function graph(dataArray:Array, dataLabels:Array, color:GouraudMaterial, width:uint,height:uint ) 
		{	
			graphWidth = width;
			graphHeight = height;
			barPadding = 50;
			//calc the width of each bar
			barWidth = (graphWidth / dataArray.length) - barPadding;
			
			barColor = color;
			
			
			// find out the largest number in the array. 
			sortedArray = new Array();
			dataArray.forEach(function(v:uint, i:int, a:Array):void {
				sortedArray.push(v);
			});
			sortedArray.sort(16);
			barHeightMultiplicator = sortedArray[sortedArray.length - 1]; 
			
			
			barContainer = new DisplayObject3D();
			
			
			dataArray.forEach(generateBar);		
			dataLabels.forEach(generateLabels);
			
			//center reference point
			barContainer.x = -(width / 2);
			barContainer.y = -(height / 2);
			
			addChild(barContainer);
		}
		private function generateBar(element:uint, index:int, array:Array):void {
			//calc each bar height relative to highest one
			barHeight = graphHeight * (element / barHeightMultiplicator);
			//calc offset compared to 0,0
			barOffset = (barWidth + barPadding) * index + barWidth/2;
			
			var materiallist:MaterialsList = new MaterialsList({all:barColor});
			var cube:Cube;
			cube = new Cube(materiallist, barWidth, barWidth, barHeight);
			cube.x = barOffset;
			
			//place on axis line
			cube.y = barHeight/2;
			barContainer.addChild(cube);
			
		}
		private function generateLabels(element:String, index:int, array:Array):void {
			//calc offset compared to 0,0
			barOffset = (barWidth + barPadding) * index + barWidth / 2;
			
			//create plane element with text
			var p:Plane;
			p = createPlane(500, barWidth, element , new TextFormat(null, 48), AntiAliasType.ADVANCED, true, false);
			
			//position element
			p.rotationZ = -90;
			p.y = -270;
			p.x = barOffset;
			barContainer.addChild(p);
		}
		public function createPlane(width:Number, height:Number, message:String, format:TextFormat, alias:String, transparant:Boolean, smooth:Boolean):Plane {
			//make a new movieclip with the supplied text			
			var mc:MovieClip = new MovieClip();
			var txt:TextField = new TextField();
			txt.wordWrap = false;
			txt.width = width;
			txt.height = height;
			txt.multiline = false;
			txt.htmlText = message;
			
			txt.autoSize = TextFieldAutoSize.LEFT;
			if (format) {
				txt.setTextFormat(format);
			}
			txt.antiAliasType = alias;
			//fill the movieclip with background colour and text
			mc.graphics.beginFill(0xffffff);
			mc.graphics.drawRect(0, 0, width, height);
			mc.graphics.endFill();
			mc.addChild(txt);
			
			//make new material
			var mat:MovieMaterial = new MovieMaterial(mc,false, false, true);
			mat.doubleSided = true;
			mat.smooth = true;//for good looking text
			mat.tiled = true;
			
			var p:Plane = new Plane(mat, width, height);
			return p;
		}
		
	}
	
}