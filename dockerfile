
# Use an official Nginx image as a base
FROM nginx:alpine

# Copy the HTML and CSS files to the Nginx server's HTML directory
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./index.css /usr/share/nginx/html/index.css
COPY ./images /usr/share/nginx/html/images

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
