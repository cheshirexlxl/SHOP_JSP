package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shop.dao.UserRepository;
import shop.dto.PersistentLogin;
import shop.dto.User;

import java.io.IOException;
import java.net.URLDecoder;

@WebFilter(description = "자동 로그인 등 인증 처리 필터", urlPatterns = { "/*" })
public class LoginFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 6470731114379833406L;	

	Cookie[] cookies;
	UserRepository userDAO;
	
    public LoginFilter() {
        super();        
    }
    
    public void init(FilterConfig fConfig) throws ServletException {
    	userDAO = new UserRepository();    
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/**
		 * TODO: 쿠키 정보와 DB 정보를 확인하여 자동 로그인 기능을 구현
		 * - 쿠키 정보 "rememberMe", "token"을 가져와 변수에 저장한다.
		 * - 쿠키 정보 "rememberMe", "token" 가 모두 존재하는 경우, 자동 로그인을 설정한 경우로 판단한다.
		 * - 자동 로그인을 설정한 경우, 테이블 [persistent_logins] 에서 해당 token을 조건으로 login_id를 조회하여 session 에 "loginId" 라는 속성명으로 등록한다.
		 */		
		
		// 쿠키 확인
    	// 1. 자동 로그인 여부
    	// 2. 인증 토큰 검증		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession();
    	Cookie[] cookies = httpRequest.getCookies();
    	
    	String rememberMe = null;		// 자동 로그인 여부
    	String token = null;			// 인증 토큰
    	
    	if( cookies != null ) {
    		for (Cookie cookie : cookies) {
    			String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8") ;
				switch (cookieName) {
					case "rememberMe"	: rememberMe = cookieValue; break;
					case "token"		: token = cookieValue; break;
				}
			}
    	}
    	System.out.println("LoginFilter...");
    	System.out.println("rememberMe : " + rememberMe);
    	System.out.println("token : " + token);
    	
    	// 로그인 여부 확인    	
    	String loginId = (String) session.getAttribute("loginId"); 
    	
    	// 이미 로그인 됨
		if( loginId != null ) {
			chain.doFilter(request, response);
			System.out.println("로그인된 사용자 : " + loginId);
			return;
		}
    	
    	// 자동 로그인 & 토큰 OK
    	if( rememberMe != null && token != null ) {
    		System.out.println("rememberMe : " + rememberMe);
    		System.out.println("token : " + token);
    		PersistentLogin persistentLogin = userDAO.selectTokenByToken(token);    		  		
    		// 토큰이 존재 & 유효 OK
    		if( persistentLogin != null ) {
    			loginId = persistentLogin.getUserId(); 
    			session.setAttribute("loginId", loginId);
    			
				System.out.println("loginId : " + loginId);								
				System.out.println("자동 로그인 성공!");   			
    		}
    	}		
		chain.doFilter(request, response);
	}
	
	public void destroy() {
		
	}

}
