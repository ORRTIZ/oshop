<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderSalesHistory}</h3>
    </div>
    <div class="panel-body">
        <table id="orderSalesHistory" summary="This table display order sales history." width="100%">
            <thead>
        <tr>
          <th>${uiLabelMap.OrderOrder} ${uiLabelMap.CommonNbr}</th>
          <th>${uiLabelMap.CommonDate}</th>
          <th>${uiLabelMap.CommonTime}</th>
          <th>${uiLabelMap.CommonStatus}</th>
          <th align="right">${uiLabelMap.CommonAmount}</th>
          <th>${uiLabelMap.OrderInvoices}</th>
        </tr>
      </thead>
      <tbody>
        <#if orderHeaderList?has_content>
          <#list orderHeaderList as orderHeader>
            <#assign status = orderHeader.getRelatedOne("StatusItem", true) />
            <#assign orderDate = orderHeader.orderDate />
            <#assign orderTime = orderHeader.orderDate />
            <tr>
              <td><a href="<@ofbizUrl>order?orderId=${orderHeader.orderId}</@ofbizUrl>" class="btn btn-default btn-xs">${orderHeader.orderId}</a></td>
              <td>${orderDate?date}</td>
              <td>${orderDate?time}</td>
              <td>${status.get("description",locale)}</td>
              <td align="right"><@ofbizCurrency amount=orderHeader.grandTotal isoCode=orderHeader.currencyUom /></td>
              <#-- invoices -->
              <#assign invoices = delegator.findByAnd("OrderItemBilling", Static["org.ofbiz.base.util.UtilMisc"].toMap("orderId", "${orderHeader.orderId}"), Static["org.ofbiz.base.util.UtilMisc"].toList("invoiceId"), false) />
              <#assign distinctInvoiceIds = Static["org.ofbiz.entity.util.EntityUtil"].getFieldListFromEntityList(invoices, "invoiceId", true)>
              <#if distinctInvoiceIds?has_content>
                <td>
                  <#list distinctInvoiceIds as invoiceId>
                     <a href="<@ofbizUrl>invoice.pdf?invoiceId=${invoiceId}</@ofbizUrl>" class="btn btn-default btn-xs">${invoiceId} PDF</a>
                  </#list>
                </td>
              <#else>
                <td></td>
              </#if>
          </#list>
        <#else>
          <tr><td colspan="6">${uiLabelMap.OrderNoOrderFound}</td></tr>
        </#if>
        </tbody>
        </table>
    </div>
</div>