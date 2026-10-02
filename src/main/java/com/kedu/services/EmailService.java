package com.kedu.services;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

@Service
public class EmailService {
	
	private String senderEmail = System.getenv("GOTT_EMAIL");
	private String senderPassword = System.getenv("GOTT_EMAIL_PASSWORD");
	
	public void sendEmail(String receiverEmail, String code) throws Exception {
		Properties props = new Properties();
		
		 // Gmail SMTP 서버
        props.put("mail.smtp.host", "smtp.gmail.com");

        // SMTP 포트
        props.put("mail.smtp.port", "587");

        // Gmail 로그인 필요
        props.put("mail.smtp.auth", "true");

        // STARTTLS 사용
        props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			 protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(
                        senderEmail,
                        senderPassword
                );
            }
		});
		
//		메일 작성
        MimeMessage message = new MimeMessage(session);

//      보내는 사람
        message.setFrom(new InternetAddress(senderEmail));

//      받는 사람
        message.setRecipient(
                Message.RecipientType.TO,
                new InternetAddress(receiverEmail)
        );

//      제목
        message.setSubject("[GOTT] 비밀번호 찾기 인증번호");

// 		내용
        message.setText(
                "GOTT 비밀번호 찾기 인증번호입니다.\n\n"
                + "인증번호 : " + code
                + "\n\n"
                + "본인이 요청하지 않은 경우 이 메일을 무시해주세요."
        );


//      메일 발송
        Transport.send(message);
		
		
	}
	
}
