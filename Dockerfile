# Build the project using a builder image
# Image can be found here: https://catalog.redhat.com/software/containers/ubi9/nodejs-16/61a60604c17162a20c1c6a2e
FROM registry.redhat.io/ubi9/nodejs-16:1-59 as BUILDER

ADD ./ $HOME

RUN npm install

# Final image uses minimal version from Red Hat
# Image can be found here: https://catalog.redhat.com/software/containers/ubi9/nodejs-16-minimal/61a6059abfd4a5234d59621f
FROM registry.redhat.io/ubi9/nodejs-16-minimal:1-67 

COPY --from=BUILDER $HOME $HOME

EXPOSE 8080

CMD ["npm", "start"]
