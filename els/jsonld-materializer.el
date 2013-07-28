<element name="v-jsonld-materializer" constructor="VJsonLdMaterializer")

<script>
var forLife= require("for-life")
var VJsonLdMaterializerProto= Object.create(HTMLElement.prototype)
VJsonLdMaterializerProto.readyCallback= function(){
	var queue= forLife("v-jsonld",document),
	  elTempalte= document.getElementById("elTemplate")
	function fetch(o){
		var jsonld= eval(this.textContent),
		  type= this.getAttribute("type") || jsonld["@type"],
		  ctxEl= document.getElementById(o.context)
		var el
		if(type)
			el= ctxEl.elName[type]
		if(!el)
			throw "Did not find @type "+type
		var inst= new el()
		o.id && inst.setAttribute("data-jsonld-src",o.id)
		document.body.appendChild(inst)
		queue.get().then(fetch)
	}
	queue.get().then(fetch)
}
var VJsonLdMaterializer= document.register("v-jsonld-materializer",{prototype:VJsonLdMaterializerProto})
</script>
</polymer-element>
