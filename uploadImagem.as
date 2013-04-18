package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.DataEvent;
	import flash.events.IOErrorEvent;
	import flash.system.Security;
	import flash.system.System;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.net.URLRequestMethod;
	
	public class uploadImagem extends MovieClip 
		{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			System.useCodePage = false;
			
			//var mural_nome:String;
			//var mural_area:String;
			//var retorno:String;
			//var erroAlerta:String;
											
			//txtFrase.tabIndex = 11;
			//txtFrase.text = "";
					
			//McBarra.visible = false;
			//progressBar.visible = false;
					
			var URLrequest:URLRequest = new URLRequest("http://zeus/testeUploadFlash/salvarImagem.php");
			var variables:URLVariables = new URLVariables();
				
			var sendEmail:URLLoader = new URLLoader();
			var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.npg)", "*.jpg; *.jpeg; *.gif; *.png;");
			var allTypes:Array = new Array(imageTypes);
			var fileRef:FileReference = new FileReference();
	
			public function uploadImagem() 
				{	
					fileRef.addEventListener(Event.SELECT, syncVariables);
					fileRef.addEventListener(Event.COMPLETE, completeHandler);
					fileRef.addEventListener(ProgressEvent.PROGRESS, progressHandler);
					
					btnEscolher.buttonMode = true;
					btnEscolher.addEventListener(MouseEvent.CLICK, browseBox);
					
					btnEnviar.buttonMode = true;
					btnEnviar.addEventListener(MouseEvent.CLICK, uploadVars);
				}
				
				
			public function browseBox(event:MouseEvent):void 
				{
					fileRef.browse(allTypes);
				}
	
			public function uploadVars(event:MouseEvent):void 
				{
					variables.frase = "frase";
					fileRef.upload(URLrequest);
					fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, retornoUpload)
					fileRef.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				}

			public function syncVariables(event:Event):void 
				{
					btnEnviar.visible = true;
					progressBar.visible = true;
					McBarra.visible = true;
					progressBar.width = 2;
					variables.todayDate = new Date();
					URLrequest.method = URLRequestMethod.POST;
					URLrequest.data = variables;
				}


			public function completeHandler(event:Event):void
				{
					txtAlerta.text = "o arquivo: "+ fileRef.name + " foi enviado.";
				}
	
			public function progressHandler(event:ProgressEvent):void 
				{
					progressBar.width = Math.ceil(133*(event.bytesLoaded/event.bytesTotal));
				}
	
			public function retornoUpload (event:DataEvent):void
				{
				if(event.data == "&erro=0")
					{
						txtAlerta.text = "Obrigado! Você já está participando. Sua foto e frase já estão disponíveis para visualização no hotsite.";
						McBarra.visible = false;
						progressBar.visible = false;
					}
				}





		function ioErrorHandler(event:IOErrorEvent):void 
			{
				trace("ioErrorHandler: " + event);
			}				
	}	
}