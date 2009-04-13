package  
{
	import org.papervision3d.materials.special.LineMaterial;
	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.core.geom.renderables.Line3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.objects.DisplayObject3D;
	
	public class lines extends DisplayObject3D
	{
		
		public function lines(width:uint, height:uint ):void 
		{
			// the axis container
			var defaultMaterial:LineMaterial = new LineMaterial(0xFFFFFF);
			var axes:Lines3D = new Lines3D(defaultMaterial);

			// Create a different colour line material for each axis
			var xAxisMaterial:LineMaterial = new LineMaterial(0xFF0000);
			var yAxisMaterial:LineMaterial = new LineMaterial(0x00FF00);
			// Create a origin vertex
			var origin:Vertex3D = new Vertex3D(0, 0, 0);

			// Create new axis lines
			var xAxis:Line3D = new Line3D(axes, xAxisMaterial, 2, origin, new Vertex3D(1000, 0, 0));
			var yAxis:Line3D = new Line3D(axes, yAxisMaterial, 2, origin, new Vertex3D(0, 500, 0));
			
			// Add lines to the Lines3D container
			axes.addLine(xAxis);
			axes.addLine(yAxis);
			
			//center the referention point
			axes.x = -(width / 2);
			axes.y = -(height / 2);
			addChild(axes);
		}
		
	}
	
}