package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import java.io.IOException;

@WebFilter("/AuthenFilter")
public class AuthenFilter extends HttpFilter implements Filter {

	
	public AuthenFilter() {
		super();		
	}
	
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("AuthenFilter 초기화 - init()...");
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("AuthenFilter 필터 - doFilter()...");
		chain.doFilter(request, response);
	}

	public void destroy() {
		System.out.println("AuthenFilter 해제 - destoroy()...");
	}

}
