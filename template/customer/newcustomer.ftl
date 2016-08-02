<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#if getUsername>
<script type="text/javascript">
  //<![CDATA[
     lastFocusedName = null;
     function setLastFocused(formElement) {
         lastFocusedName = formElement.name;
         document.write.lastFocusedName;
     }
     function clickUsername() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             if (lastFocusedName == "UNUSEEMAIL") {
                 jQuery('#PASSWORD').focus();
             } else if (lastFocusedName == "PASSWORD") {
                 jQuery('#UNUSEEMAIL').focus();
             } else {
                 jQuery('#PASSWORD').focus();
             }
         }
     }
     function changeEmail() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             document.getElementById('USERNAME').value = jQuery('#CUSTOMER_EMAIL').val();
         }
     }
     function setEmailUsername() {
         if (document.getElementById('UNUSEEMAIL').checked) {
             document.getElementById('USERNAME').value = jQuery('#CUSTOMER_EMAIL').val();
             // don't disable, make the browser not submit the field: document.getElementById('USERNAME').disabled=true;
         } else {
             document.getElementById('USERNAME').value='';
             // document.getElementById('USERNAME').disabled=false;
         }
     }
     function hideShowUsaStates() {
         var customerStateElement = document.getElementById('newuserform_stateProvinceGeoId');
          var customerCountryElement = document.getElementById('newuserform_countryGeoId');
         if (customerCountryElement.value == "USA" || customerCountryElement.value == "UMI") {
             customerStateElement.style.display = "block";
         } else {
             customerStateElement.style.display = "none";
         }
     }
   //]]>
</script>
</#if>

<#------------------------------------------------------------------------------
NOTE: all page headings should start with an h2 tag, not an H1 tag, as 
there should generally always only be one h1 tag on the page and that 
will generally always be reserved for the logo at the top of the page.
------------------------------------------------------------------------------->
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.PartyRequestNewAccount}</h3>
        <span>${uiLabelMap.PartyAlreadyHaveAccount}, <a href='<@ofbizUrl>checkLogin/main</@ofbizUrl>' class="btn btn-default btn-xs">${uiLabelMap.CommonLoginHere}</a></span>
    
<#macro fieldErrors fieldName>
  <#if errorMessageList?has_content>
    <#assign fieldMessages = Static["org.ofbiz.base.util.MessageString"].getMessagesForField(fieldName, true, errorMessageList)>
    <ul>
      <#list fieldMessages as errorMsg>
        <li class="errorMessage">${errorMsg}</li>
      </#list>
    </ul>
  </#if>
</#macro>
<#macro fieldErrorsMulti fieldName1 fieldName2 fieldName3 fieldName4>
  <#if errorMessageList?has_content>
    <#assign fieldMessages = Static["org.ofbiz.base.util.MessageString"].getMessagesForField(fieldName1, fieldName2, fieldName3, fieldName4, true, errorMessageList)>
    <ul>
      <#list fieldMessages as errorMsg>
        <li class="errorMessage">${errorMsg}</li>
      </#list>
    </ul>
  </#if>
</#macro>
        <br/>
        <p class="desc">${uiLabelMap.CommonFieldsMarkedAreRequired}</p>
    </div>
    <div class="panel-body">
<form method="post" action="<@ofbizUrl>createcustomer${previousParams}</@ofbizUrl>" id="newuserform" name="newuserform">
  
  
  <#----------------------------------------------------------------------
  If you need to include a brief explanation of the form, or certain 
  elements in the form (such as explaining asterisks denote REQUIRED),
  then you should use a <p></p> tag with a class name of "desc"
  ----------------------------------------------------------------------->

  <#----------------------------------------------------------------------
  There are two types of fieldsets, regular (full width) fielsets, and
  column (half width) fieldsets. If you want to group two sets of inputs
  side by side in two columns, give each fieldset a class name of "col"
  ----------------------------------------------------------------------->

  
    <input type="hidden" name="emailProductStoreId" value="${productStoreId}"/>
    <#----------------------------------------------------------------------
    Each input row should be enclosed in a <div></div>. 
    This will ensure than each input field clears the one
    above it. Alternately, if you want several inputs to float next to
    each other, you can enclose them in a table as illustrated below for
    the phone numbers, or you can enclose each label/input pair in a span

    Example:
    <div>
      <span>
        <input type="text" name="expMonth" value=""/>
        <label for="expMonth">Exp. Month</label>
      </span>
      <span>
        <input type="text" name="expYear" value=""/>
        <label for="expYear">Exp. Year</label>
      </span>
    </div>
    ----------------------------------------------------------------------->
    <div class="row">
        <div class="col-md-6">
            <#include "NewCustomerName.ftl" />
            <#include "NewCustomerEmail.ftl" />
        </div>
        <div class="col-md-6">
            <#include "NewCustomerAccount.ftl" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <#include "NewCustomerAddress.ftl" />
        </div>
        <div class="col-md-6">
            <#include "NewCustomerTelco.ftl" />
        </div>
    </div>
</form>

<#------------------------------------------------------------------------------
To create a consistent look and feel for all buttons, input[type=submit], 
and a tags acting as submit buttons, all button actions should have a 
class name of "button". No other class names should be used to style 
button actions.
------------------------------------------------------------------------------->
    <div class="buttons">  
        &nbsp;<a href="<@ofbizUrl>${donePage}</@ofbizUrl>" class="btn btn-warning">${uiLabelMap.CommonCancel}</a>
        &nbsp;<a href="javascript:document.getElementById('newuserform').submit()" class="btn btn-success">${uiLabelMap.CommonSave}</a>   
    </div>
    </div>
</div>
<script type="text/javascript">
  //<![CDATA[
      hideShowUsaStates();
  //]]>
</script>
