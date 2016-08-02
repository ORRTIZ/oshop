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
<form name="configform" id="configFormId" method="post" action="<@ofbizUrl>product<#if requestAttributes._CURRENT_VIEW_??>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>">
    <input type='hidden' name='add_product_id' value='${product.productId}' />
    <input type='hidden' name='add_category_id' value='' />
    <input type='hidden' name='quantity' value='1' />
    <input type='hidden' name='product_id' value='${product.productId}' />
    <table >
        <tr>
            <td>
                <div>
                    <a href="javascript:verifyConfig();" class="buttontext">${uiLabelMap.OrderVerifyConfiguration}</a>
                </div>
            </td>
        </tr>

        <#assign counter = 0>
        <#assign questions = configwrapper.questions>
        <#list questions as question>
            <tr>
                <td>
                    <div>${question.question}</div>
                    <#if question.isFirst()>
                        <a name='#${question.getConfigItem().getString("configItemId")}'></a>
                        <div>${StringUtil.wrapString(question.description!)}</div>
                        <#assign instructions = question.content.get("INSTRUCTIONS", "html")!>
                        <#if instructions?has_content>
                            <a href="javascript:showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${instructions}");" class="buttontext">Instructions</a>
                        </#if>
                        <#assign image = question.content.get("IMAGE_URL", "url")!>
                        <#if image?string?has_content>
                            <img src='<@ofbizContentUrl>${contentPathPrefix!}${image!}</@ofbizContentUrl>' vspace='5' hspace='5' class='cssImgXLarge' align='left' alt="" />
                        </#if>
                    <#else>
                        <div><a href='#${question.getConfigItem().getString("configItemId")}' class="buttontext">Details</a></div>
                    </#if>
                </td>
            </tr>
            <tr>
                <td>
                    <#if question.isStandard()>
                        <#-- Standard item: all the options are always included -->
                        <#assign options = question.options>
                        <#list options as option>
                            <div>${option.description} <#if !option.isAvailable()> (*)</#if></div>
                        </#list>
                    <#else>
                        <#if question.isSingleChoice()>
                            <#-- Single choice question -->
                            <#assign options = question.options>
                            <#assign selectedOption = question.getSelected()!>
                            <#assign selectedPrice = 0.0>
                            <#if selectedOption?has_content>
                                <#assign selectedPrice = selectedOption.getPrice()>
                            </#if>
                            <#-- The single choice input can be implemented with radio buttons or a select field -->
                            <#if renderSingleChoiceWithRadioButtons?? && "Y" == renderSingleChoiceWithRadioButtons>
                                <#-- This is the radio button implementation -->
                                <#if !question.isMandatory()>
                                    <div><input type="radio" name='${counter}' value='<#if !question.isSelected()>checked</#if>' /> No option</div>
                            </#if>
                            <#assign optionCounter = 0>
                                <#list options as option>
                                        <#assign componentCounter = 0>
                                        <#if showOffsetPrice?? && "Y" == showOffsetPrice>
                                            <#assign shownPrice = option.price - selectedPrice>
                                        <#else>
                                            <#assign shownPrice = option.price>
                                        </#if>
                                        <#-- Render virtual componennts -->
                                        <#if option.hasVirtualComponent()>
                                        <div>
                                            <input type='radio' name='${counter}' id="${counter}_${optionCounter}" value='${optionCounter}' onclick="javascript:checkOptionVariants('${counter}_${optionCounter}');" />
                                            ${option.description} <#if !option.isAvailable()> (*)</#if>
                                            <#assign components = option.getComponents()>
                                            <#list components as component>
                                                <#if (option.isVirtualComponent(component))>
                                                    ${setRequestAttribute("inlineProductId", component.productId)}
                                                    ${setRequestAttribute("inlineCounter", counter+ "_" +optionCounter + "_"+componentCounter)}
                                                    ${setRequestAttribute("addJavaScript", componentCounter)}
                                                    ${screens.render(inlineProductDetailScreen)}
                                                    <#assign componentCounter = componentCounter + 1>
                                                </#if>
                                            </#list>
                                        </div>
                                    <#else>
                                        <div>
                                            <input type="radio" name='${counter}' value='${optionCounter}' <#if option.isSelected() || (!question.isSelected() && optionCounter == 0 && question.isMandatory())>checked="checked"</#if> />
                                            ${option.description}&nbsp;
                                            <#if (shownPrice > 0)>+<@ofbizCurrency amount=shownPrice isoCode=price.currencyUsed/>&nbsp;</#if>
                                            <#if (shownPrice < 0)>-<@ofbizCurrency amount=(-1*shownPrice) isoCode=price.currencyUsed/>&nbsp;</#if>
                                            <#if !option.isAvailable()>(*)</#if>
                                        </div>
                                    </#if>
                                    <#assign optionCounter = optionCounter + 1>
                                </#list>
                            <#else>
                                <#-- And this is the select box implementation -->
                                <select name='${counter}'>
                                    <#if !question.isMandatory()>
                                        <option value=''>---</option>
                                    </#if>
                                    <#assign options = question.options>
                                    <#assign optionCounter = 0>
                                    <#list options as option>
                                        <#if showOffsetPrice?? && "Y" == showOffsetPrice>
                                            <#assign shownPrice = option.price - selectedPrice>
                                        <#else>
                                            <#assign shownPrice = option.price>
                                        </#if>
                                        <#if option.isSelected()>
                                            <#assign optionCounter = optionCounter + 1>
                                        </#if>
                                        <option value='${optionCounter}' <#if option.isSelected()>selected="selected"</#if>>
                                            ${option.description}&nbsp;
                                            <#if (shownPrice > 0)>+<@ofbizCurrency amount=shownPrice isoCode=price.currencyUsed/>&nbsp;</#if>
                                            <#if (shownPrice < 0)>-<@ofbizCurrency amount=(-1*shownPrice) isoCode=price.currencyUsed/>&nbsp;</#if>
                                            <#if !option.isAvailable()> (*)</#if>
                                        </option>
                                        <#assign optionCounter = optionCounter + 1>
                                    </#list>
                                </select>
                            </#if>
                        <#else>
                            <#-- Multi choice question -->
                            <#assign options = question.options>
                            <#assign optionCounter = 0>
                            <#list options as option>
                                <#assign componentCounter = 0>
                                <#-- Render virtual components -->
                                <#if option.hasVirtualComponent()>
                                    <div >
                                        <input type='CHECKBOX' name='${counter}' id="${counter}_${optionCounter}" value='${optionCounter}' onclick="javascript:checkOptionVariants('${counter}_${optionCounter}');" />
                                        ${option.description} <#if !option.isAvailable()> (*)</#if>
                                        <#assign components = option.getComponents()>
                                        <#list components as component>
                                            <#if (option.isVirtualComponent(component))>
                                                ${setRequestAttribute("inlineProductId", component.productId)}
                                                ${setRequestAttribute("inlineCounter", counter+ "_" +optionCounter + "_"+componentCounter)}
                                                ${setRequestAttribute("addJavaScript", componentCounter)}
                                                ${screens.render(inlineProductDetailScreen)}
                                                <#assign componentCounter = componentCounter + 1>
                                            </#if>
                                        </#list>
                                    </div>
                                <#else>
                                    <div>
                                        <input type='CHECKBOX' name='${counter}' value='${optionCounter}' <#if option.isSelected()>checked="checked"</#if> />
                                        ${option.description} +<@ofbizCurrency amount=option.price isoCode=price.currencyUsed/><#if !option.isAvailable()> (*)</#if>
                                    </div>
                                </#if>
                                <#assign optionCounter = optionCounter + 1>
                            </#list>
                        </#if>
                    </#if>
                </td>
            </tr>
            <#assign counter = counter + 1>
        </#list>
    </table>
</form>