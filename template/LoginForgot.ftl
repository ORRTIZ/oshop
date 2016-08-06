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
<fieldset>
    <legend>
        <h3 class="panel-title">${uiLabelMap.CommonForgotYourPassword}</h3>
    </legend>
    <div>
        <form method="post" action="<@ofbizUrl>forgotpassword</@ofbizUrl>" class="horizontal">
            <div class="row">
                <div class="col-md-4">
                    <label for="forgotpassword_userName">${uiLabelMap.CommonUsername}</label>
                </div>
                <div class="col-md-8">
                    <input type="text" id="forgotpassword_userName" name="USERNAME" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>"/>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    &nbsp;
                </div>
                <div class="col-md-8">
                    
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-8">
                    <input type="submit" class="btn btn-default btn-xs" name="GET_PASSWORD_HINT" value="${uiLabelMap.CommonGetPasswordHint}"/>
                    <input type="submit" class="btn btn-default btn-xs" name="EMAIL_PASSWORD" value="${uiLabelMap.CommonEmailPassword}"/>
                </div>
            </div>
        </form>
    </div>
</legend>