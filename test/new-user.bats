setup_file() {
    load 'test_helper/common-setup'
    _common_setup
    docker build --quiet \
                 "--build-arg=BASE_IMAGE=${MICROMAMBA_IMAGE}" \
                 "--tag=${MICROMAMBA_IMAGE}-new-user" \
		 "--file=${PROJECT_ROOT}/test/new-user.Dockerfile" \
		 "${PROJECT_ROOT}/test" > /dev/null
}

setup() {
    load 'test_helper/common-setup'
    _common_setup
}

# Test .bashrc activation for a fresh user by disabling the entrypoint script.
@test "'docker run --rm -it --entrypoint=/bin/bash ${MICROMAMBA_IMAGE}-new-user' with 'python --version; exit'" {
    input="python --version; exit"
    echo -e $input | faketty \
        docker run --rm -it --entrypoint=/bin/bash "${MICROMAMBA_IMAGE}-new-user"

    # Make sure that a similar command actually fails
    input="xyz --version; exit"
    ! echo -e $input | faketty \
        docker run --rm -it --entrypoint=/bin/bash "${MICROMAMBA_IMAGE}-new-user"
}
