package org.extremecomponents.table.view.html;

import org.extremecomponents.table.core.TableModel;
import org.extremecomponents.table.limit.Limit;
import org.extremecomponents.util.HtmlBuilder;

import com.handpay.ibenefit.framework.util.MessageUtils;

public class StatusBarBuilder {
	   private HtmlBuilder html;
	    private TableModel model;

	    public StatusBarBuilder(TableModel model) {
	        this(new HtmlBuilder(), model);
	    }
	    
	    public StatusBarBuilder(HtmlBuilder html, TableModel model) {
	        this.html = html;
	        this.model = model;
	    }

	    public HtmlBuilder getHtmlBuilder() {
	        return html;
	    }

	    protected TableModel getTableModel() {
	        return model;
	    }

	    public void statusMessage() {
	        if (model.getLimit().getTotalRows() == 0) {
	            html.append(MessageUtils.getMessage(BuilderConstants.STATUSBAR_NO_RESULTS_FOUND,model.getLocale()));
	        } else {
	            Integer total = new Integer(model.getLimit().getTotalRows());
	            Integer from = new Integer(model.getLimit().getRowStart() + 1);
	            Integer to = new Integer(model.getLimit().getRowEnd());
	            int totalPage = (total-1)/model.getLimit().getCurrentRowsDisplayed() + 1;
	            Object[] messageArguments = { total, from, to, totalPage};
	            html.append(MessageUtils.getMessage(BuilderConstants.STATUSBAR_RESULTS_FOUND, messageArguments, model.getLocale()));
	        }
	    }
	    
	    public String toString() {
	        return html.toString();
	    }
}
