package com.oracle.projectGo.configuration;

import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Optional;
import java.util.UUID;

@RequiredArgsConstructor
@Component
@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

    private final UsersService us;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        UUID transactionId = UUID.randomUUID();
        String username = "";
        String password = "";
        /*List<GrantedAuthority> authorities = new ArrayList<>();*/
        try {
            log.info("[{}]{}:{}",transactionId, "AuthenticationProvider", "start");
            username = authentication.getName();
            password = authentication.getCredentials().toString();
            log.info(username);
            log.info(password);
            log.info("username:{}",username);
            Optional<Users> user = us.getUserByNickname(username);
            log.info("user:{}",user);
//	        Optional<Users> user = userService.getUserById(Integer.parseInt(username));
            if (user == null) {
                throw new BadCredentialsException("username is not found. username=" + username);
            }
            if (!password.equals(user.get().getPassword())) {
                throw new BadCredentialsException("password is not matched");
            }
//

        } catch (Exception e) {
            log.error("[{}]{}:{}",transactionId, "AuthenticationProvider", e.getMessage());
            throw e;  // 추가된 부분
        } finally {
            log.info("[{}]{}:{}",transactionId, "AuthenticationProvider", "end");
        }
        
        return new UsernamePasswordAuthenticationToken(username, password);
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
    }


}