<!-- surveys -->
<div class="panel panel-default">
    <div class="panel-heading">
         <h3 class="panel-title">${uiLabelMap.CommonSurveys}</h3>
    </div>
    <div class="panel-body">
        <#if surveys?has_content>
            <table width="100%" border="0" cellpadding="1">
                <#list surveys as surveyAppl>
                    <#assign survey = surveyAppl.getRelatedOne("Survey", false) />
                    <tr>
                        <td>&nbsp;</td>
                        <td valign="top"><div>${survey.surveyName!}&nbsp;-&nbsp;${survey.description!}</div></td>
                        <td>&nbsp;</td>
                        <td valign="top">
                            <#assign responses = Static["org.ofbiz.product.store.ProductStoreWorker"].checkSurveyResponse(request, survey.surveyId)?default(0)>
                            <#if (responses < 1)>${uiLabelMap.EcommerceNotCompleted}<#else>${uiLabelMap.EcommerceCompleted}</#if>
                        </td>
                        <#if (responses == 0 || survey.allowMultiple?default("N") == "Y")>
                            <#assign surveyLabel = uiLabelMap.EcommerceTakeSurvey />
                            <#if (responses > 0 && survey.allowUpdate?default("N") == "Y")>
                                <#assign surveyLabel = uiLabelMap.EcommerceUpdateSurvey />
                            </#if>
                            <td align="right"><a href="<@ofbizUrl>takesurvey?productStoreSurveyId=${surveyAppl.productStoreSurveyId}</@ofbizUrl>" class="button">${surveyLabel}</a></td>
                        <#else>
                            &nbsp;
                        </#if>
                    </tr>
                </#list>
            </table>
        </#if>
    </div>
</div>