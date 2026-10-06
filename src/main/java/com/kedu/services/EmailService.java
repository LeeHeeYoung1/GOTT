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
		
        props.put("mail.smtp.host", "smtp.gmail.com");

        props.put("mail.smtp.port", "587");

        props.put("mail.smtp.auth", "true");

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
		
        MimeMessage message = new MimeMessage(session);

        message.setFrom(new InternetAddress(senderEmail));

        message.setRecipient(
                Message.RecipientType.TO,
                new InternetAddress(receiverEmail)
        );

        message.setSubject("[GOTT] 비밀번호 찾기 인증번호");

        message.setText(
                "GOTT 비밀번호 찾기 인증번호입니다." 
                + "\n\n"
                + "인증번호 : " + code
                + "\n\n"
                + "본인이 요청하지 않은 경우 이 메일을 무시해주세요.."
        );


        Transport.send(message);
		
		
	}
	
}
