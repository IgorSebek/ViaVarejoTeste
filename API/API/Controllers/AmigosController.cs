using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using API.Models;
namespace API.Controllers
{
    [RoutePrefix("api/amigos")]
    public class AmigosController : ApiController
    {

        [AcceptVerbs("GET")]
        [Route("GetBuscaAmigos/")]         
        public HttpResponseMessage GetBuscaAmigos(JObject dados)
        {
            AmigosDAL dal = new AmigosDAL();
            List<Amigos> lista = dal.retornaAmigos();

            return Request.CreateResponse(HttpStatusCode.OK, lista); 

        }



        [AcceptVerbs("GET")]
        [Route("GetGeoPosicionamentoAmigos/")]         
        public HttpResponseMessage GetGeoPosicionamentoAmigos(JObject dados)
        {
            AmigosDAL dal = new AmigosDAL();
            List<Amigos> lista = dal.retornaDadosAmigos();

            return Request.CreateResponse(HttpStatusCode.OK, lista);

        }



    }
}
