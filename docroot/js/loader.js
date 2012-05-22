/*
 * Author : mark.ibbotson@manheim.co.uk (Ibbo)
 * Purpose: dynamically load javascript based upon current page
 * Version: 1.0
 * Date   : 120111 
 * NOTE   : this is how its done !!
 */

jQuery.loader = {
    
    path: window.location.pathname.split('/'),
    
    init: function () {

       var module = this.path[1]; 
        
       switch (module) 
        {
            case "article":
               jQuery.getScript('/js/article.js' , function() {
                 	jQuery.article.init();
               });                
            break;

            case "socket":
               jQuery.getScript('/js/socket.js');
            break;  

            default:
               
            break;
        }   
    }    
};