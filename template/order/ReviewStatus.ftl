<div class="panel panel">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.CommonStatus}</h3>
    </div>
    <div class="panel-body">
        <#if orderHeader?has_content>
            ${localOrderReadHelper.getStatusString(locale)}
        <#else>
            ${uiLabelMap.OrderNotYetOrdered}
        </#if>
    </div>
</div>