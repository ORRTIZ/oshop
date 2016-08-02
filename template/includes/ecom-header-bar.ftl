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
<div id="left" class="col-md-6">
    <#include "../catalog/MainNav.ftl" />
</div>
<div id="right" class="col-md-6">
    <div class="row">
        <div class="col-md-9"> 
            <#include "../catalog/SimpleSearch.ftl" />
        </div>
        <div class="col-md-3">
            <#assign shoppingCart = sessionAttributes.shoppingCart!>
            <#if shoppingCart?has_content>
                <#assign shoppingCartSize = shoppingCart.size()>
            <#else>
                <#assign shoppingCartSize = 0>
            </#if>
            <#if (shoppingCartSize > 0)>
                <a href="#" class="btn btn-warning" 
                    title="${uiLabelMap.OrderCartSummary}" 
                    data-delay="{show: 500, hide: 100}"
                    data-toggle="popover" 
                    data-trigger="hover focus" 
                    data-html="true"
                    data-placement="auto" 
                    data-content='<#include "../cart/PopOverCart.ftl"/>'>
                        <span class="glyphicon glyphicon-shopping-cart"></span> ${uiLabelMap.OrderCheckout} >
                </a>
            <#else>
                <a href="#" class="btn btn-warning"  
                    data-delay="{show: 500, hide: 100}"
                    data-toggle="popover" 
                    data-trigger="hover focus" 
                    data-html="true"
                    data-placement="auto" 
                    data-content='<#include "../cart/PopOverCart.ftl"/>'>
                        <span class="glyphicon glyphicon-shopping-cart"></span> 
                </a>
            </#if>
        </div>
    </div>
</div>