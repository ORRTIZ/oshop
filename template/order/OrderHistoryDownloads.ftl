
<#if downloadOrderRoleAndProductContentInfoList?has_content>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.EcommerceDownloadsAvailableTitle}</h3>
    </div>
    </div>
    <div class="panel-body"
        <table id="availableTitleDownload" summary="This table display available title for download.">
            <thead>
                <tr>
                    <th>${uiLabelMap.OrderOrder} ${uiLabelMap.CommonNbr}</th>
                    <th>${uiLabelMap.ProductProductName}</th>
                    <th>${uiLabelMap.CommonName}</th>
                    <th>${uiLabelMap.CommonDescription}</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <#if downloadOrderRoleAndProductContentInfoList?has_content>
                    <#list downloadOrderRoleAndProductContentInfoList as downloadOrderRoleAndProductContentInfo>
                        <tr>
                        <td>${downloadOrderRoleAndProductContentInfo.orderId}</td>
                        <td>${downloadOrderRoleAndProductContentInfo.productName}</td>
                        <td>${downloadOrderRoleAndProductContentInfo.contentName!}</td>
                        <td>${downloadOrderRoleAndProductContentInfo.description!}</td>
                        <td>
                            <a href="<@ofbizUrl>downloadDigitalProduct?dataResourceId=${downloadOrderRoleAndProductContentInfo.dataResourceId}</@ofbizUrl>" class="button">Download</a>
                        </td>
                        </tr>
                    </#list>
                <#else>
                    <tr><td colspan="5"><br/>${uiLabelMap.EcommerceDownloadNotFound}</td></tr>
                </#if>
            </tbody>
        </table>
    </div>
</div>
</#if>