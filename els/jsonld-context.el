<element name="v-jsonld-context">

<template id="elTemplate">
<element name="{{nameEl}}" constructor="{{nameJs}}">
<script>
var {{nameJs+"Proto"}}= Object.create(HTMLElement.prototype)
{{nameJs+"Proto"}}.ns= {{ns}}
{{nameJs+"Proto"}}.readyCallback= function(){
	
}
var {{name}}= document.register("{{nameEl}}}",{prototype:{{nameJs+"Proto"}} })
</script>
</element>
</template>

<script>
var VJsonLdContextProto= Object.create(HTMLElement.prototype)
VJsonLdContextProto.readyCallback= function(){
	this.template= this.getElementById("elTemplate")

	var val= eval(this.textContent)
	this.context= val["@context"]
	this.fullContext= {}
	this.idContext= {}
	this.typeContext= {}
	this.elContext= {}
	this.setAttribute("context",this.context)

	for(var i in this.context){
		var c= this.context[i],
		  id= i
		if(c instanceof String){
			this.fullContext[i]= {"@id": c, "@type": "@id"}
			this.idContext[i]= c
			this.typeContext[i]= "@id"
		}else{
			var id= c["@id"]
			if(!id) throw "No id"
			this.fullContext[i]= o
			this.idContext= id
			this.typeContext= c["@type"]||"@id"
		}
		var el= this.createEl(this.context[i],i)
		this.el[i]= el
		this.elName[i]= eval(i) // fetch the global constructor for the el
	}
}
VJsonLdContextProto.createEl= function(ns,short){
	var o= {nameEl: "jsonld-"+short,
	  nameJs: short,
	  ns: ns}
	this.template.model= o
	return document.body.appendChild(this.template.content.cloneNode(true))
}
var VJsonLdContext= document.register("v-jsonld-context",{prototype:VJsonLdContextProto})
</script>
</element>
