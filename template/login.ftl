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
<#assign janrainEnabled = Static["org.ofbiz.entity.util.EntityUtilProperties"].getPropertyValue("ecommerce", "janrain.enabled", delegator)>
<#--
(C) Copyright 2015 Somonar B.V.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

 -->
<#assign appName = Static["org.ofbiz.entity.util.EntityUtilProperties"].getPropertyValue("ecommerce", "janrain.appName", delegator)>

<#if janrainEnabled == "Y">
    <#include "LoginJanrain.ft"/>
<#else>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">${uiLabelMap.CommonLogin}</h3>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <#include "LoginMain.ftl"/>
                </div>
                <div class="col-md-6">
                    <#include "LoginForgot.ftl"/>
                </div>
            </div>
        <div>
    </div>
</#if>
    <div class="endcolumns">&nbsp;</div>
<script language="JavaScript" type="text/javascript">
  <#if autoUserLogin?has_content>document.loginform.PASSWORD.focus();</#if>
  <#if !autoUserLogin?has_content>document.loginform.USERNAME.focus();</#if>
</script>
