package br.com.sisfie.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLConnection;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * Este Servlet carrega um aimagem armazenada no hd
 */
public class LoadImageHDServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Get file name from reques
		// Capturando o caminho do arquivo atraves do request
		String imageFileName = request.getParameter("file");

		if (imageFileName != null) {
			imageFileName = imageFileName.replaceAll("\\.+(\\\\|/)", "");

			// Decode the file name and prepare file object.
			imageFileName = URLDecoder.decode(imageFileName, "UTF-16");

			// Get content type by filename.
			String contentType = URLConnection.guessContentTypeFromName(imageFileName);

			File file = new File(imageFileName);

			// Preparando os streams
			BufferedInputStream input = null;
			BufferedOutputStream output = null;

			try {
				// Abrindo a imagem
				input = new BufferedInputStream(new FileInputStream(file));
				int contentLength = input.available();

				// Init servlet response.
				response.reset();
				response.setContentLength(contentLength);
				response.setContentType(contentType);
				response.setHeader("Content-disposition", "inline; filename=\"" + imageFileName + "\"");
				output = new BufferedOutputStream(response.getOutputStream());

				// Write file contents to response.
				while (contentLength-- > 0) {
					output.write(input.read());
				}
				// Finalizando
				output.flush();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				// Finalizando os streams
				if (input != null) {
					try {
						input.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (output != null) {
					try {
						output.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	public String getServletInfo() {
		return "Short description";
	}
}
