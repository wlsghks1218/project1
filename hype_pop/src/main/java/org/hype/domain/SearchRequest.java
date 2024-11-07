package org.hype.domain;

public class SearchRequest {
    private String searchText;
    private int page;

    // Getter and Setter
    public String getSearchText() {
        return searchText;
    }

    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }
}